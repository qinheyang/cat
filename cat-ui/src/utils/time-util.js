export function dateformat (date,format) {
	const year = date.getFullYear();
	const month = String(date.getMonth() + 1).padStart(2, '0');
	const day = String(date.getDate()).padStart(2, '0');
	const hours = String(date.getHours()).padStart(2, '0');
	const minutes = String(date.getMinutes()).padStart(2, '0');
	const seconds = String(date.getSeconds()).padStart(2, '0');
	if(format=="YYYY-MM-DD HH:mm:ss"){
		return `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`;
	}else if(format=="YYYY-MM-DD"){
		return `${year}-${month}-${day}`;
	}
	return null;

}
