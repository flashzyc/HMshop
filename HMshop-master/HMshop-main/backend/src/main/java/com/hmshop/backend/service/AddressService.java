package com.hmshop.backend.service;

import com.hmshop.backend.dto.AddressSaveRequest;
import com.hmshop.backend.entity.Address;
import com.hmshop.backend.entity.User;
import com.hmshop.backend.repository.AddressRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class AddressService {
    private final AddressRepository addressRepository;

    public List<Address> list(User user) {
        return addressRepository.findByUserAndDeletedFalseOrderByAddTimeDesc(user);
    }

    public Optional<Address> save(AddressSaveRequest req, User user) {
        Address address = new Address();
        address.setUser(user);
        address.setName(req.getName());
        address.setTel(req.getTel());
        address.setCountry(req.getCountry());
        address.setProvince(req.getProvince());
        address.setCity(req.getCity());
        address.setCounty(req.getCounty());
        address.setAreaCode(req.getAreaCode());
        address.setPostalCode(req.getPostalCode());
        address.setAddressDetail(req.getAddressDetail());
        address.setIsDefault(Boolean.TRUE.equals(req.getIsDefault()));
        address.setAddTime(LocalDateTime.now());
        address.setUpdateTime(LocalDateTime.now());
        address.setDeleted(false);

        if (Boolean.TRUE.equals(req.getIsDefault())) {
            addressRepository.findByUserAndIsDefaultTrueAndDeletedFalse(user)
                    .ifPresent(old -> {
                        old.setIsDefault(false);
                        addressRepository.save(old);
                    });
        }
        addressRepository.save(address);
        return Optional.of(address);
    }

    public void deleteOne(User user, Long id) {
        Optional<Address> target;
        if (id != null) {
            target = addressRepository.findByIdAndUser(id, user);
        } else {
            target = addressRepository.findByUserAndIsDefaultTrueAndDeletedFalse(user);
            if (target.isEmpty()) {
                List<Address> list = list(user);
                if (!list.isEmpty()) {
                    target = Optional.of(list.get(0));
                }
            }
        }
        target.ifPresent(addr -> {
            addr.setDeleted(true);
            addressRepository.save(addr);
        });
    }
}
