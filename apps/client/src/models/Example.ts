export interface IExampleRaw {
    id: string;
    message: string;
}

export interface IExample {
    id: string;
    message: string;
}

export interface IExamplePostBody {
    id: string;
    message: string;
}

export class Example implements IExample {
    id: string;

    message: string;

    constructor(props: IExampleRaw) {
        this.id = props.id;
        this.message = props.message;
    }
}
