interface IConfig {
    baseURL: string;
}

export const config: IConfig = {
    baseURL: process.env.REACT_APP_BASE_URL || '',
};
