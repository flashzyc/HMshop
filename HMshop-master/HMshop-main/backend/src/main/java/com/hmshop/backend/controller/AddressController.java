package com.hmshop.backend.controller;

import com.hmshop.backend.common.ApiResponse;
import com.hmshop.backend.dto.AddressSaveRequest;
import com.hmshop.backend.entity.Address;
import com.hmshop.backend.entity.User;
import com.hmshop.backend.service.AddressService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/wx/address")
@RequiredArgsConstructor
public class AddressController extends BaseController {

    private final AddressService addressService;

    @GetMapping("/list")
    public ApiResponse<Map<String, Object>> list(HttpServletRequest request) {
        User user = getCurrentUser(request);
        if (user == null) {
            return needLogin();
        }
        List<Address> addresses = addressService.list(user);
        Map<String, Object> data = new HashMap<>();
        data.put("list", addresses);
        return ApiResponse.ok(data);
    }

    @PostMapping("/save")
    public ApiResponse<Map<String, Object>> save(HttpServletRequest request,
                                                 @Valid @RequestBody AddressSaveRequest req) {
        User user = getCurrentUser(request);
        if (user == null) {
            return needLogin();
        }
        Address address = addressService.save(req, user).orElse(null);
        Map<String, Object> data = new HashMap<>();
        data.put("id", address != null ? address.getId() : null);
        return ApiResponse.ok("保存成功", data);
    }

    @PostMapping("/delete")
    public ApiResponse<?> delete(HttpServletRequest request, @RequestParam(required = false) Long id) {
        User user = getCurrentUser(request);
        if (user == null) {
            return needLogin();
        }
        addressService.deleteOne(user, id);
        return ApiResponse.ok("删除成功", null);
    }
}
