package com.hmshop.backend.dto;

import jakarta.validation.constraints.NotBlank;
import lombok.Data;

@Data
public class AddressSaveRequest {
    @NotBlank
    private String name;
    @NotBlank
    private String tel;
    private String country;
    @NotBlank
    private String province;
    @NotBlank
    private String city;
    @NotBlank
    private String county;
    private String areaCode;
    private String postalCode;
    @NotBlank
    private String addressDetail;
    private Boolean isDefault;
}
