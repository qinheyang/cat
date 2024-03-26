<template>
  <el-dialog
    :title="dialogFormTitle"
    :visible.sync="dialogFormVisible"
    class="save-form-div"
    :close-on-click-modal="$globeValue.clickModalClose"
    @closed="closed()"
  >
    <el-form
      v-loading="loading"
      :model="saveForm"
      :rules="rules"
      ref="saveForm"
      label-width="85px"
      size="medium"
    >
      <el-row :gutter="20">
        <el-col :span="12">
          <el-form-item prop="catName" label="猫咪名称">
            <el-input
              placeholder="请输入猫咪名称"
              v-model="saveForm.catName"
              maxlength="10"
              auto-complete="off"
            >
            </el-input>
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item prop="firstWitness" label="第一次目击">
            <el-input
              placeholder="请输入第一次目击时间"
              v-model="saveForm.firstWitness"
              maxlength="10"
              auto-complete="off"
            >
            </el-input>
          </el-form-item>
        </el-col>
      </el-row>
      <el-row :gutter="20">
        <el-col :span="12">
          <el-form-item prop="color" label="毛色">
            <el-input
              placeholder="请输入猫咪毛色"
              v-model="saveForm.color"
              maxlength="10"
              auto-complete="off"
            >
            </el-input>
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item prop="disposition" label="性格">
            <el-input
              placeholder="请输入猫咪的性格特点"
              v-model="saveForm.disposition"
              maxlength="20"
              auto-complete="off"
            >
            </el-input>
          </el-form-item>
        </el-col>
      </el-row>
      <el-row :gutter="20">
        <el-col :span="12">
          <el-form-item prop="state" label="状况">
            <el-select
              v-model="saveForm.state"
              clearable
              placeholder="请选择状况"
            >
              <el-option
                v-for="item in stateList"
                :key="item.value"
                :label="item.label"
                :value="item.value"
              >
              </el-option>
            </el-select>
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item prop="sex" label="性别">
            <el-select
              v-model="saveForm.sex"
              clearable
              placeholder="请选择性别"
            >
              <el-option
                v-for="item in sexList"
                :key="item.value"
                :label="item.label"
                :value="item.value"
              >
              </el-option>
            </el-select>
          </el-form-item>
        </el-col>
      </el-row>
      <el-row :gutter="20">
        <el-col :span="12">
          <el-form-item prop="isSterile" label="是否绝育">
            <el-radio-group v-model="saveForm.isSterile">
              <el-radio :label="false">未绝育</el-radio>
              <el-radio :label="true">已绝育</el-radio>
            </el-radio-group>
          </el-form-item>
        </el-col>
        <el-col :span="12" v-show="saveForm.isSterile">
          <el-form-item prop="sterileTime" label="绝育时间">
            <el-date-picker
              style="width: 100%"
              v-model="saveForm.sterileTime"
              value-format="yyyy-MM-dd HH:mm:ss"
              type="datetime"
              placeholder="选择绝育时间"
            >
            </el-date-picker>
          </el-form-item>
        </el-col>
      </el-row>

      <el-form-item prop="apperance" label="外貌">
        <el-input
          type="textarea"
          placeholder="请输入猫咪的外貌特点"
          v-model="saveForm.appearance"
          maxlength="100"
          auto-complete="off"
        >
        </el-input>
      </el-form-item>
      <el-form-item prop="avatar" label="照片">
        <avatar-copper
          @finishUpload="finishUpload"
          :initialImg="saveForm.picture"
        >
        </avatar-copper>
      </el-form-item>
    </el-form>
    <div slot="footer" class="dialog-footer">
      <el-button type="primary" @click="submitForm('saveForm')"
        >确 定</el-button
      >
      <el-button @click="cancel">取 消</el-button>
    </div>
  </el-dialog>
</template>
<style lang="scss" scoped>
.avatar-uploader .el-upload {
  border: 1px dashed #d9d9d9;
  border-radius: 6px;
  cursor: pointer;
  position: relative;
  overflow: hidden;
}
.avatar-uploader .el-upload:hover {
  border-color: #409eff;
}
.avatar-uploader-icon {
  font-size: 28px;
  color: #8c939d;
  width: 250px;
  height: 250px;
  line-height: 250px;
  text-align: center;
}
.avatar {
  width: 250px;
  height: 250px;
  display: block;
}
.save-form-div form {
  width: 100%;
}
.el-select {
  width: 100%;
}
</style>
<script>
import { updateCat, addCat, getCatInfo } from "@/api/cat-manage/cat";
import { upload } from "@/api/common";
import avatarCopper from "@/components/avatar-copper";
export default {
  components: {
    avatarCopper,
  },
  watch: {
    "saveForm.isSterile": {
      handler(newVal) {
        if (newVal == false) {
          this.saveForm.sterileTime = null;
        }
      },
    },
  },
  data() {
    return {
      saveForm: {
        catId: undefined,
        catName: undefined,
        state: "0",
        color: undefined,
        sex: "0",
        isSterile: false,
        sterileTime: null,
        firstWitness: undefined,
        disposition: undefined,
        appearance: undefined,
        picture: undefined,
        avatar: undefined,
      },
      menuList: [],
      menuTreeProps: {
        id: "menuId",
        label: "menuName",
        children: "children",
      },
      stateList: [
        { label: "健康", value: "0" },
        { label: "送养", value: "1" },
        { label: "失踪", value: "2" },
        { label: "离世", value: "3" },
      ],
      sexList: [
        { label: "公", value: "0" },
        { label: "母", value: "1" },
        { label: "未知", value: "2" },
      ],
      loading: false,
      dialogFormVisible: false,
      dialogFormTitle: undefined,
      rules: {
        catName: [
          { required: true, message: "请输入猫咪名", trigger: "blur" },
        ],
      },
    };
  },

  methods: {
    submitForm(formName) {
      this.$refs[formName].validate((valid) => {
        if (valid) {
          if (this.saveForm.catId === undefined) {
            addCat(this.saveForm).then(() => {
              this.cancel();
              this.$emit("refresh-list");
              this.$message.success("保存成功");
            });
          } else {
            updateCat(this.saveForm).then(() => {
              this.cancel();
              this.$emit("refresh-list");
              this.$message.success("保存成功");
            });
          }
        }
      });
    },
    resetForm(formName) {
      this.saveForm = {
        catId: undefined,
        catName: undefined,
        state: "0",
        color: undefined,
        sex: "0",
        isSterile: false,
        sterileTime: null,
        firstWitness: undefined,
        disposition: undefined,
        appearance: undefined,
        picture: undefined,
        avatar: undefined,
      };
      this.$refs[formName].resetFields();
    },
    openDialog(catId) {
      if (catId === undefined) {
        this.dialogFormTitle = "猫咪档案新增";
      } else {
        this.dialogFormTitle = "猫咪档案修改";
        getCatInfo(catId).then((resp) => {
          this.saveForm = resp.data;
        });
      }
      this.dialogFormVisible = true;
    },

    cancel() {
      this.dialogFormVisible = false;
    },
    closed() {
      this.resetForm("saveForm");
    },
    uploadPicture(params) {
      const formData = new FormData();
      formData.append("file", params.file);
      upload(formData).then((res) => {
        this.saveForm.picture = res.url;
      });
    },
    finishUpload(cutImg, originImg) {
      this.saveForm.avatar = cutImg;
      this.saveForm.picture = originImg;
    },
  },
};
</script>
