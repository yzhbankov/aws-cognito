import React from 'react';
import {useAuth} from 'react-oidc-context';
import {config} from '../config';

export function Example() {
    const auth = useAuth();
    const [data, setData] = React.useState(null);

    React.useEffect(() => {
        (async () => {
            try {
                const token = auth.user?.access_token;
                const response = await fetch(`${config.baseURL}/prod/api/v1/example`, {
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
