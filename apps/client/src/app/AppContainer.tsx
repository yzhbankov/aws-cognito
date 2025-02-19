import React, {useEffect} from 'react';
import {useAuth} from 'react-oidc-context';
import {config} from '../config';
import {Example} from './Example';

export function AppContainer() {
    const auth = useAuth();

    useEffect(() => {
        // Clear the query parameters if the user is authenticated
        if (auth.isAuthenticated) {
            const url = new URL(window.location.href);
            url.search = ''; // Clear the query parameters
            window.history.replaceState({}, document.title, url.toString());
        }
    }, [auth.isAuthenticated]);

    const signOutRedirect = () => {
        const cognitoDomain = "https://user-pool-domain-yz.auth.us-east-1.amazoncognito.com";
        window.location.href = `${cognitoDomain}/logout?client_id=${config.cognitoClientId}}`;
    };

    if (auth.isLoading) {
        return <div>Loading...</div>;
    }

    if (auth.error) {
        return <div>Encountering error... {auth.error.message}</div>;
    }

    if (auth.isAuthenticated) {
        return (
            <div>
                <pre> Hello: {auth.user?.profile.email} </pre>
                <pre> ID Token: {auth.user?.id_token} </pre>
                <pre> Access Token: {auth.user?.access_token} </pre>
                <pre> Refresh Token: {auth.user?.refresh_token} </pre>

                <Example />

                <button onClick={() => auth.removeUser()}>Sign out</button>
            </div>
        );
    }

    return (
        <div>
            <button onClick={() => auth.signinRedirect()}>Sign in</button>
            <button onClick={() => signOutRedirect()}>Sign out</button>
        </div>
    );
}
