package com.bsk.dao;


import com.bsk.po.Address;

import java.util.List;

public interface AddressDao {
    List<Address> getAddress(Address address);
    void setAddress(Address address);
    void delAddress(Integer id);
    void addAddress(Address address);
    void setAddressForUser(Address address);
}
