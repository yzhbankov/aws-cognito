import React from 'react';
import {useAuth} from 'react-oidc-context';

export function Example() {
    const auth = useAuth();
    const [data, setData] = React.useState(null);

    React.useEffect(() => {
        (async () => {
            try {
                const token = auth.user?.access_token;
                const response = await fetch('https://3yb7wmqypk.execute-api.us-east-1.amazonaws.com/prod/api/v1/example', {
                    headers: {
                        Authorization: `Bearer ${token}`,
                    },
                });
                setData(await response.json());
            } catch (e) {
                console.error(e);
            }
        })();
    }, [auth]);

    if (!data) {
        return <div>Loading...</div>;
    }

    return <div>{JSON.stringify(data)}</div>;
}
