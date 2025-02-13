import React from 'react';
import ReactDOM from 'react-dom/client';
import {BrowserRouter} from 'react-router-dom';
import {AuthProvider} from 'react-oidc-context';
import {config} from './config';
import {AppContainer} from './app/AppContainer';
import reportWebVitals from './reportWebVitals';
import './index.css';

const cognitoAuthConfig = {
    authority: `https://cognito-idp.${config.cognitoRegion}.amazonaws.com/${config.userPoolId}` || '',
    client_id: config.cognitoClientId,
    redirect_uri: config.baseURL,
    response_type: "code",
    scope: "phone openid email",
    // authority: "https://cognito-idp.us-east-1.amazonaws.com/us-east-1_v9CP7to1V",
    // client_id: "1ria7tf7dfeestp40b7id2unq2",
    // redirect_uri: "https://did7zqra4ypp2.cloudfront.net",
};

console.log('cognitoAuthConfig ', cognitoAuthConfig);

const root = ReactDOM.createRoot(document.getElementById('root') as HTMLElement);
root.render(
    <React.StrictMode>
        <BrowserRouter>
            <AuthProvider {...cognitoAuthConfig}>
                <AppContainer/>
            </AuthProvider>
        </BrowserRouter>
    </React.StrictMode>
);

// If you want to start measuring performance in your app, pass a function
// to log results (for example: reportWebVitals(console.log))
// or send to an analytics endpoint. Learn more: https://bit.ly/CRA-vitals
reportWebVitals();
