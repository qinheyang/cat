package com.sad.web.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableLogic;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.datatype.jsr310.deser.LocalDateTimeDeserializer;
import com.fasterxml.jackson.datatype.jsr310.ser.LocalDateTimeSerializer;
import com.sad.web.entity.BaseEntity;

import java.time.LocalDateTime;
import java.util.Date;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;

/**
 * <p>
 * 
 * </p>
 *
 * @author Qinhy
 * @since 2023-10-11 10:03:05
 */
@Getter
@Setter
@TableName("`t_cat`")
@ApiModel(value = "Cat对象", description = "")
public class Cat extends BaseEntity {

    @ApiModelProperty("猫咪id")
    @TableId(value = "cat_id", type = IdType.AUTO)
    private Long catId;

    @ApiModelProperty("猫咪名称")
    @TableField("cat_name")
    private String catName;

    @ApiModelProperty("猫咪状况：0：健康，1：送养，2：失踪，3：离世")
    @TableField("state")
    private String state;

    @ApiModelProperty("毛色")
    @TableField("color")
    private String color;

    @ApiModelProperty("性别：0：公，1：母，2：未知")
    @TableField("sex")
    private String sex;

    @ApiModelProperty("是否绝育0：未绝育，1：绝育")
    @TableField("is_sterile")
    private Boolean isSterile;

    @ApiModelProperty("绝育时间")
    @TableField("sterile_time")
    @JsonDeserialize(using = LocalDateTimeDeserializer.class)
    @JsonSerialize(using = LocalDateTimeSerializer.class)
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private LocalDateTime sterileTime;

    @ApiModelProperty("第一次目击")
    @TableField("first_witness")
    private String firstWitness;

    @ApiModelProperty("性格")
    @TableField("disposition")
    private String disposition;

    @ApiModelProperty("外貌")
    @TableField("appearance")
    private String appearance;

    @ApiModelProperty("图片相对路径")
    @TableField("picture")
    private String picture;

    @ApiModelProperty("头像图片相对路径")
    @TableField("avatar")
    private String avatar;

    @ApiModelProperty("删除标志（0代表未删除，1代表已删除）")
    @TableField("del_flag")
    @TableLogic
    private Boolean delFlag;





}
