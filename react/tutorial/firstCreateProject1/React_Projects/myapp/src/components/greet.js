import React from 'react';

//  TODO javascript class 공부.
//  TODO javascript import 공부.
class Greet extends React.Component {
    constructor(props) {
        super(props);

        this.state = {val: "awesome"};
    }

    changeValue = () => {
        this.setState(
            {val: "wonderful"}
        );
    }

    render() {
        return (
            <div>
                <h1>Hello {this.state.val} World</h1>
                <button type="button" onClick={this.changeValue}>Change value</button>
            </div>
        )
    }
}

export default Greet;