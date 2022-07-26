export async function grabBook(book: string): Promise<number> {
    const axios = require('axios').default;
    return axios.get(`https://ip.jsontest.com/${book}`)
        .then(async function (response: any) {
            return response?.data?.book?.replace(/[^0-9-\.]/g, '');
        })
        .catch(function (error: any) {
            console.log(error);
        });
}
