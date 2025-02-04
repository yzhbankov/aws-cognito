import {Axios} from 'axios';
import {Example, IExampleRaw, IExample} from '../../models';

export interface IAxiosExampleApi {
    read: () => Promise<IExample|null>;
}

export class AxiosExampleApi implements IAxiosExampleApi {
    private http: Axios;

    constructor(http: Axios) {
        this.http = http;
    }

    async read(): Promise<IExample|null> {
        const response = await this.http.get('/api/v1/example');
        if (response) {
            response.data = response.data.map((item: IExampleRaw) => new Example(item));
            return response.data;
        }
        return null;
    }
}
