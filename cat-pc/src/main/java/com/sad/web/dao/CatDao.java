package com.sad.web.dao;

import com.sad.web.entity.Cat;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author Qinhy
 * @since 2023-10-11 10:03:05
 */
@Mapper
public interface CatDao extends BaseMapper<Cat> {

    Cat getDetailByCatName(@Param("catName") String catName);
}
