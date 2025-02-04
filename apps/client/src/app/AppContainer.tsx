import React from 'react';
import { Route, Routes } from 'react-router-dom';
import { App } from './App';

export function AppContainer() {
    return (
        <>
            <Routes>
                <Route path="/" element={<App />} />
            </Routes>
        </>
    );
}

AppContainer.defaultProps = {};

AppContainer.propTypes = {};
