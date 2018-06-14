package com.qzq.haha.MyShopService.Impl;

import com.qzq.haha.MyShopDao.ArticleTypeMapper;
import com.qzq.haha.MyShopService.ArticleTypeService;
import com.qzq.haha.POJO.ArticleType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class ArticleTypeServiceImpl implements ArticleTypeService {
    @Autowired
    ArticleTypeMapper articleTypeMapper;
    @Override
    public List<ArticleType> listAll() {
        return  articleTypeMapper.listAll();
    }
}
