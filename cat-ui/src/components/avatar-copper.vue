<template>
  <div class="cropper-content">
    <el-row>
      <el-col :span="14">
        <div class="cropper" style="text-align: center">
          <vueCropper
            style="width:100px,height:100px"
            ref="cropper"
            :img="option.img"
            :output-size="option.size"
            :output-type="option.outputType"
            :info="true"
            :full="option.full"
            :can-move="option.canMove"
            :can-move-box="option.canMoveBox"
            :original="option.original"
            :auto-crop="option.autoCrop"
            :autoCropWidth="option.autoCropWidth"
            :autoCropHeight="option.autoCropHeight"
            :fixed="option.fixed"
            :fixed-number="option.fixedNumber"
            :center-box="option.centerBox"
            :info-true="option.infoTrue"
            :fixed-box="option.fixedBox"
            @realTime="realTime"
          ></vueCropper>
        </div>
      </el-col>
      <el-col :span="10">
        <div class="show-preview">
          <div :style="previews.div" class="preview">
            <img :src="previews.url" :style="previews.img" />
          </div>
        </div>
      </el-col>
    </el-row>
    <el-row style="margin-top: 10px">
      <el-col :span="5">
        <el-upload
          class="upload-demo"
          action="#"
          :http-request="selectImg"
          accept=".jpg,.jpeg,.png,.JPG,.PNG"
          :show-file-list="false"
        >
          <el-button plain size="small" icon="el-icon-upload">选择</el-button>
        </el-upload>
      </el-col>
      <el-col :span="8">
        <el-button
          plain
          size="small"
          icon="el-icon-plus"
          @click="changeScale(1)"
        ></el-button>
        <el-button
          plain
          size="small"
          icon="el-icon-minus"
          @click="changeScale(-1)"
        ></el-button>
        <el-button
          plain
          size="small"
          icon="el-icon-refresh-left"
          @click="rotateLeft()"
        ></el-button>
        <el-button
          plain
          size="small"
          icon="el-icon-refresh-right"
          @click="rotateRight()"
        ></el-button>
      </el-col>
      <el-col :offset="1" :span="10" style="text-align: center">
        <el-button type="primary" size="small" @click="onConfirm('blob')"
          >上传</el-button
        >
      </el-col>
    </el-row>
  </div>
</template>
<script>
import { upload } from "@/api/common";
export default {
  props: {
    initialImg: {
      type: String,
      require: false,
    },
  },
  watch: {
    initialImg(val) {
      if (val) {
        this.option.img =
          process.env.VUE_APP_BASE_API + process.env.VUE_APP_BASE_URL + val;
          this.resultPath.originImg=val;
      } else {
        this.option.img = val;
        this.resultPath = {
          originImg: "",
          cutImg: "",
        };
      }
    },
  },
  data() {
    return {
      previews: {},
      option: {
        img: "",
        outputSize: 1, // 裁剪生成图片的质量 0.1 - 1
        outputType: "png", //	裁剪生成图片的格式 jpeg || png || webp
        canScale: true, // 图片是否允许滚轮缩放 默认true
        autoCrop: true, // 是否默认生成截图框 默认false
        canMove: true, //上传图片是否可以移动 默认true
        autoCropWidth: "150", //默认生成截图框宽度	容器的80%	0~max
        autoCropHeight: "150", //默认生成截图框高度	容器的80%	0~max
        fixedBox: true, // 固定截图框大小 不允许改变	false	true | false
        fixed: true, //是否开启截图框宽高固定比例
        original: false, // 上传图片按照原始比例渲染	false	true | false
        infoTrue: false, // 为展示真实输出图片宽高 false 展示看到的截图框宽高	false	true | false
        centerBox: true, // 截图框是否被限制在图片里面	false	true | false
        canMoveBox: true, //截图框能否拖动	true	true | false
      },
      resultPath: {
        originImg: "",
        cutImg: "",
      },
    };
  },
  methods: {
    // 初始化函数
    imgLoad(msg) {
      console.log("工具初始化函数=====" + msg);
    },
    // 图片缩放
    changeScale(num) {
      num = num || 1;
      this.$refs.cropper.changeScale(num);
    },
    // 向左旋转
    rotateLeft() {
      console.log(this.option.img);
      console.log(this.initialImg);
      this.$refs.cropper.rotateLeft();
    },
    // 向右旋转
    rotateRight() {
      this.$refs.cropper.rotateRight();
    },
    // 实时预览函数
    realTime(data) {
      this.previews = data;
    },
    // 选择图片
    selectImg(params) {
      const file = params.file;
      const fileSuffix = file.name.substring(file.name.lastIndexOf("."));
      if (!/\.(jpg|jpeg|png|JPG|PNG)$/.test(fileSuffix)) {
        this.$message({
          message: "图片类型要求：jpeg、jpg、png",
          type: "error",
        });
        return false;
      }
      const formData = new FormData();
      formData.append("file", file);
      upload(formData).then((res) => {
        this.resultPath.originImg = res.fileName;
        this.option.img = res.url;
      });
    },
    // 上传图片
    onConfirm(type) {
      if (type === "blob") {
        // 获取截图的blob数据
        this.$refs.cropper.getCropBlob((blob) => {
          this.updatePhoto(blob);
        });
      }
    },

    async updatePhoto(blob) {
      try {
        const formData = new FormData();
        formData.append("file", blob, ".jpg");
        await upload(formData).then((res) => {
          this.resultPath.cutImg = res.fileName;
          this.$message.success("上传头像成功");
          this.$emit(
            "finishUpload",
            this.resultPath.cutImg,
            this.resultPath.originImg
          );
        });
      } catch (error) {
        this.$message.error("修改头像失败！");
      }
    },
  },
};
</script>
<style scoped lang="scss">
.cropper-content .cropper {
  width: 350px;
  height: 250px;
}
.show-preview {
  flex: 1;
  -webkit-flex: 1;
  display: flex;
  display: -webkit-flex;
  justify-content: center;
  align-items: center;
  height: 250px;
  .preview {
    border-radius: 50%;
    overflow: hidden;
    background: #cccccc;
  }
}
</style>

