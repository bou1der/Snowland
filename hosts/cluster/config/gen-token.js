const args = process.argv.splice(2);
if (args.length != 3) {
	throw new Error("Ошибка");
}

const API_KEY = args[0];
const API_URL = args[1];
const USERNAME = args[2];

const baseUrl = API_URL;
const headers = new Headers();

headers.set("Authorization", `Bearer ${API_KEY}`);

async function createUser(name) {
	const url = new URL("/api/v1/user", baseUrl);
	url.searchParams.append("name", name);

	const existUser = await fetch(url, {
		method: "GET",
		headers,
	}).then(async (r) => await r.json());

	if (existUser.users[0]) {
		return existUser.users[0];
	}

	const req = await fetch(url, {
		method: "POST",
		body: JSON.stringify({
			name,
		}),
		headers,
	}).then(async (v) => await v.json());
	return req.user;
}

async function createPreauthKey(name) {
	const url = new URL("/api/v1/preauthkey", baseUrl);
	const req = await fetch(url, {
		method: "POST",
		body: JSON.stringify({
			user: name,
			reusable: false,
			expiration: new Date(
				new Date().setFullYear(new Date().getFullYear() + 1),
			),
		}),
		headers,
	}).then(async (v) => await v.json());
	return req;
}

async function main() {
	const user = await createUser(USERNAME);
	const preauth = await createPreauthKey(user.name);
	process.stdout.write(preauth.preAuthKey.key);
}

main();
