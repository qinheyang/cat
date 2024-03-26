package com.sad.web.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.sad.web.entity.Cat;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author Qinhy
 * @since 2023-10-11 10:03:05
 */
public interface ICatService extends IService<Cat> {

    public IPage<Cat> list(Cat cat, Integer pageNum, Integer pageSize);

    public int  add(Cat cat);

    public int update(Cat cat);

    public int deleteByIds(Long[] catIds);

    public  List<Cat> list(Cat cat);

    public Cat getDetailByCatName(String catName);
}
