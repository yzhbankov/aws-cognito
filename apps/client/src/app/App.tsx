import React from 'react';
import {useAuth} from 'react-oidc-context';
import {Example} from './Example';

export function App() {
    const auth = useAuth();

    switch (auth.activeNavigator) {
        case "signinSilent":
            return <div>Signing you in...</div>;
        case "signoutRedirect":
            return <div>Signing you out...</div>;
    }

    if (auth.isLoading) {
        return <div>Loading...</div>;
    }

    if (auth.error) {
        return <div>Oops... {auth.error.message}</div>;
    }

    if (auth.isAuthenticated) {
        return (
            <div>
                Hello {auth.user?.profile.sub}{" "}
                <Example />
                <button onClick={() => auth.removeUser()}>Log out</button>
            </div>
        );
    }

    return <button onClick={() => auth.signinRedirect()}>Log in</button>;
}
