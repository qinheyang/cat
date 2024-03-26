import request from "@/utils/request";
const prefix = '/cat-manage/cat/'

export function listCat (params) {
	return request({
		url: prefix + 'list',
		method: 'get',
		params: params
	})
}
export function addCat (params) {
	return request({
		url: prefix + 'add',
		method: 'post',
		data: params
	})
}
export function updateCat (params) {
	return request({
		url: prefix + 'update',
		method: 'put',
		data: params
	})
}
export function getCatInfo (catId) {
	return request({
		url: prefix + catId,
		method: 'get',

	})
}
export function deleteCat (catIds) {
	return request({
		url: prefix + `delete/${catIds}`,
		method: 'delete',
	})
}
