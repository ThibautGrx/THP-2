import React from 'react';
import {Link} from 'react-router-dom';


export default class THPLink extends Link {
    render() {
        return (
            <Link {...this.props} style={{...this.props.style, textDecoration: 'none', color: 'inherit'}}>
                {this.props.children}
            </Link>
        )
    }
}
