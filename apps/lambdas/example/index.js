import { v4 as uuidv4 } from 'uuid';

const defaultHeaders = {
    'Content-Type': 'application/json',
    'Access-Control-Allow-Origin' : '*',
    'Access-Control-Allow-Methods' : 'GET, OPTIONS, POST, PUT, DELETE',
    'Access-Control-Allow-Headers' : 'Content-Type',
    'Access-Control-Allow-Credentials': 'true',
}

export const handler = async (event) => {
    try {
        const data = {
            id: uuidv4(),
            message: "Hello from Lambda"
        };
        // ..Lambda function logic
        return {
            statusCode: 200,
            body: JSON.stringify(data),
            headers: {
                ...defaultHeaders
            }
        }
    } catch (error) {
        return {
            statusCode: 500,
            body: JSON.stringify({ error: error.message }),
            headers: {
                'Content-Type': 'application/json'
            }
        };
    }
};
