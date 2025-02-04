import axios from 'axios';
import { AxiosExampleApi, IAxiosExampleApi } from './AxiosExampleApi';

type ClientOptions = { baseURL: string };

export interface IAxiosClientApi {
    readonly example: IAxiosExampleApi;
}

export class AxiosClientApi implements IAxiosClientApi {

    readonly _example: IAxiosExampleApi;

    constructor(options: ClientOptions) {
        const instance = axios.create({
            withCredentials: true, // send/receive cookie
            baseURL: options.baseURL,
            timeout: 10000,
        });
        this._example = new AxiosExampleApi(instance);
    }

    get example(): IAxiosExampleApi {
        return this._example;
    }
}
