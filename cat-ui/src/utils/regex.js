const regex = {
	phone_regex: (phone) => {
		const reg = /^1(3|4|5|6|7|8|9)\d{9}$/;
		return reg.test(phone);
	},
	email_regex: (email) => {
		const reg = /^[^\s@]+@[^\s@]+.[^\s@]+$/;

		return reg.test(email);
	}
}
export default regex;