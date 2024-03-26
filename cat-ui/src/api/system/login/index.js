import request from "@/utils/request";
const prefix = ''

export function login (params) {
  return request({
    url: prefix + '/login',
    method: 'post',
    data: params
  })
}

export function getRouters () {
  return request({
    url: prefix + '/getRouters',
    method: 'get',
  })
}
