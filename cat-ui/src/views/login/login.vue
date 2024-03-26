<template>
  <div class="login-body">
    <el-form class="login-container demo-ruleForm"
             :model="loginForm"
             status-icon
             :rules="rules"
             ref="ruleForm"
            >
      <h1 class="login-title">登录</h1>
      <el-form-item prop="userName">
  
        <el-input type="text"
                  v-model="loginForm.userName"
                  autocomplete="off"
                  placeholder="用户名"
                  class="input-box"></el-input>
      </el-form-item>
      <el-form-item prop="checkPass">
        
        <el-input type="password"
                  v-model="loginForm.password"
                  placeholder="密码"
                  autocomplete="off"
                  class="input-box">
        </el-input>
      </el-form-item>
      <el-form-item>
        <el-button type="primary"
                   round
                   @click="submitForm('ruleForm')">
          登   录
        </el-button>
      </el-form-item>
    </el-form>
  </div>
</template>

<script>
import { login } from '@/api/system/login';
import { setToken, removeToken } from '@/utils/auth'
export default {
  name: "login",
  data () {
    return {
      loginForm: {
        userName: "",
        password: "",

      },
      rules: {
        userName: [{ required: true, message: '请输入昵称', trigger: "blur" }],
        password: [{ required: true, message: '请输入密码', trigger: "blur" }],

      },
    };
  },
  methods: {
    submitForm (formName) {
      this.$refs[formName].validate((valid) => {
        if (valid) {
          const loading = this.$loading({
            lock: true,
            text: '登录中',
            spinner: 'el-icon-loading',
            background: 'rgba(0, 0, 0, 0.7)'
          })
          removeToken();
          login(this.loginForm).then(resp => {
            console.log(resp);
            setToken(resp.token)
            loading.close()
            this.$router.push({ path: '/' })

          }).catch(() => {
            loading.close()

          })

        } else {
          return false;
        }
      });
    },
    resetForm (formName) {
      this.$refs[formName].resetFields();
    },
  },
};
</script>
<style scoped lang="scss">
.login-body {
  width: 100%;
  height: 100%;
  background: url(@/assets/login/background.jpg);
  display: flex;
  justify-content: center;
  align-items: center;
  background-size: 100% 100%;
  background-attachment: fixed;
}
.login-container {
  height: 35%;
  width: 17%;
  border: 2px solid rgba(255, 255, 255, 0.5);
  border-radius: 20px;
  background: #f4f4f4;
  display: flex;
  flex-direction: column;

  align-items: center;
}
/deep/ .el-input__inner {
  background: transparent;
  padding: 0;
  border: 0;
  border-bottom: 2px solid silver;
  border-radius: 0%;
  font-size: 17px;
  color: 000;
}

.el-button {
  font-size: 17px;
  font-weight:900 ;
  width: auto;
  border-radius: 10%;
}
</style>