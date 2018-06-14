package com.qzq.haha.MyShopDao;

import com.qzq.haha.POJO.User;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface UserMapper {
    public User findUser(@Param("_loginName") String _loginName,@Param("_password") String _password);

}
