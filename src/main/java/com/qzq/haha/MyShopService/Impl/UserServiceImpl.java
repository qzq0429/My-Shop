package com.qzq.haha.MyShopService.Impl;

import com.qzq.haha.MyShopDao.UserMapper;
import com.qzq.haha.MyShopService.UserService;
import com.qzq.haha.POJO.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("userService")
public class UserServiceImpl implements UserService {
      @Autowired
    private UserMapper userMapper;

    @Override
    public User checkUser(String _loginname, String _password) {
        return userMapper.findUser(_loginname,_password);
    }
}
