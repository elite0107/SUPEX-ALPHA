class ApiService {
    getRequest(url) {
        return fetch(url);
    }

    postRequest(url, payload) {
        const requestOptions = {
            method: "POST",
            headers: { "Content-Type": "applications/json" },
            body: JSON.stringify(payload),
        };

        return fetch(url, requestOptions);
    }
}

export default new ApiService();
