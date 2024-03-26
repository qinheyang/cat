package com.sad.web.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.sad.web.entity.Cat;
import com.sad.web.dao.CatDao;
import com.sad.web.entity.system.SysRole;
import com.sad.web.service.ICatService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import javax.annotation.Resource;
import java.util.Arrays;
import java.util.List;

/**
 * <p>
 * 服务实现类
 * </p>
 *
 * @author Qinhy
 * @since 2023-10-11 10:03:05
 */
@Service
public class CatServiceImpl extends ServiceImpl<CatDao, Cat> implements ICatService {
    @Resource
    private CatDao catDao;

    @Override
    public IPage<Cat> list(Cat cat, Integer pageNum, Integer pageSize) {
        LambdaQueryWrapper<Cat> queryWrapper = new LambdaQueryWrapper<Cat>();
        queryWrapper.select(Cat::getCatId, Cat::getCatName, Cat::getColor,Cat::getSex, Cat::getFirstWitness, Cat::getColor, Cat::getIsSterile,Cat::getSterileTime, Cat::getState,Cat::getCreateTime);
        if (!StringUtils.isEmpty(cat.getCatName())) {
            queryWrapper.like(Cat::getCatName, "%" + cat.getCatName() + "%");
        }
        queryWrapper.orderByDesc(Cat::getCreateTime);
        Page<Cat> page = new Page<Cat>(pageNum, pageSize);
        return catDao.selectPage(page, queryWrapper);
    }

    @Override
    public int add(Cat cat) {
        return catDao.insert(cat);
    }

    @Override
    public int update(Cat cat) {
        LambdaUpdateWrapper<Cat> updateWrapper = new LambdaUpdateWrapper<Cat>();
        updateWrapper.eq(Cat::getCatId, cat.getCatId());
        return catDao.update(cat,updateWrapper);
    }

    @Override
    public int deleteByIds(Long[] catIds) {
        return catDao.deleteBatchIds(Arrays.asList(catIds));
    }

    @Override
    public List<Cat> list(Cat cat) {
        LambdaQueryWrapper<Cat> queryWrapper = new LambdaQueryWrapper<Cat>();
        queryWrapper.select(Cat::getCatId, Cat::getCatName,Cat::getAvatar);
        if (!StringUtils.isEmpty(cat.getState())) {
            queryWrapper.eq(Cat::getState, cat.getState());
        }
        queryWrapper.orderByDesc(Cat::getCreateTime);
        return catDao.selectList(queryWrapper);
    }

    @Override
    public Cat getDetailByCatName(String catName) {
        return catDao.getDetailByCatName(catName);
    }
}
