interface IConfig {
    baseURL: string;
}

export const config: IConfig = {
    baseURL: process.env.REACT_APP_BOOKMARKS_BASE_URL || '',
};
