import Vue from 'vue'
import ElementUI from 'element-ui'
import '@/assets/style/theme/index.css'
import './assets/icon/iconfont.css'
import App from '@/App.vue'
import '@/assets/globe.css'
import globeValue from '@/utils/glole'
import router from './router'
import VueCropper from 'vue-cropper'
import VirtualCollection from 'vue-virtual-collection'
import './router/permission'
import store from './store'
Vue.use(ElementUI, { size: 'small' });
Vue.use(VueCropper)
Vue.use(VirtualCollection)
Vue.config.productionTip = false
Vue.prototype.$globeValue = globeValue;
new Vue({
  router,
  store,
  render: h => h(App),
}).$mount('#app')
