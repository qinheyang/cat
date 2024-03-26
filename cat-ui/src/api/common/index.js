import request from "@/utils/request";

const prefix = '/common/'

export function upload (data) {
    return request({
        url: prefix+'upload',
        method: 'post',
        data: data,
        headers:{
            'Content-Type': 'multipart/form-data;'

        }
      })
}
