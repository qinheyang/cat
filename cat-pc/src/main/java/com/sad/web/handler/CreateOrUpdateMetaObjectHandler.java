package com.sad.web.handler;

import com.baomidou.mybatisplus.core.handlers.MetaObjectHandler;
import com.sad.web.security.SecurityUtil;
import org.apache.ibatis.reflection.MetaObject;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;
import java.util.Objects;

@Component
public class CreateOrUpdateMetaObjectHandler implements MetaObjectHandler {

    @Override
    public void insertFill(MetaObject metaObject) {
        this.strictInsertFill(metaObject,"createBy",String.class, SecurityUtil.getLoginUser().getUsername());
        this.strictInsertFill(metaObject, "createTime", LocalDateTime.class, LocalDateTime.now());
    }

    @Override
    public void updateFill(MetaObject metaObject) {
        Object obj = getFieldValByName("updateBy",metaObject);
        if (obj == null) {
            this.strictUpdateFill(metaObject,"updateBy",String.class, SecurityUtil.getLoginUser().getUsername());

        }
        this.strictUpdateFill(metaObject, "updateTime", LocalDateTime.class, LocalDateTime.now());

    }
}
