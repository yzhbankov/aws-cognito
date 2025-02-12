interface IConfig {
    baseURL: string;
    cognitoRegion: string;
    userPoolId: string;
    cognitoClientId: string;
}

export const config: IConfig = {
    baseURL: process.env.APP_BASE_URL || '',
    cognitoRegion: process.env.COGNITO_REGION || '',
    userPoolId: process.env.USER_POOL_ID || '',
    cognitoClientId: process.env.COGNITO_CLIENT_ID || '',
};
