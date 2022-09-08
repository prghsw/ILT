import React from 'react';
import ReactDOM from 'react-dom/client';
import './index.css';


//  제어되는 컴포넌트
// class Square extends React.Component {
    // constructor(props) {
        //  this.state를 설정하는 것으로 state를 가질 수 있다.
        //  무언가 기억하기 위해서는 state를 사용 한다.
        // super(props);
        // this.state = {
            // value: null,
        // };
        /*
            JavaScript 클래스에서 하위 클래스의 생성자를 정의할 때 항상 super를 호출해야합니다. 모든 React 컴포넌트 클래스는 생성자를 가질 때 super(props) 호출 구문부터 작성해야 합니다.
        */
    // }

    // render() {
    //   return (
          //    props에서 전달 받은 값 사용 하기.
          //    this.setState 를 호출 하는 것으로 React에게 다시 렌더링 해야한다고 알릴 수 있다.
          //    @1. 내장된 DOM <button> 컴포넌트에 있는 onClick prop는 React에게 클릭 이벤트 리스너를 설정하라고 알린다.
          //    @2. 버튼을 클릭하면 React는 Square의 render() 함수에 정의된 onClick 이벤트 핸들러를 호출 한다.
          //    @3. 이벤트 핸들러는 this.props.onClick()를 호출한다. Square의 onClick prop는 Board에서 정의되어 있다.
//         <button
//             className="square" 
//             onClick={() => this.props.onClick()}
//         >
//           {this.props.value}
//         </button>
//       );
//     }
//   }

// Squeare 함수 컴포넌트로 변경.
// state없이 render 함수만 가진다.
// props를 입력 받아, 렌더링할 대상을 반환하는 함수를 작성할 수 있다.
function Square(props) {
    return (
        <button className="square" onClick={props.onClick}>
            {props.value}
        </button>
    );
}

  /*
    직접적인 객체 변경, 기본 데이터 변경을 하지 않는 것에 대한 이점.
    - 복잡한 특징들을 단순하게 만듦.
    - 변화를 감지함.
    - React에서 다시 렌더링하는 시기를 결정함.
    (성능 최적화하기 > https://ko.reactjs.org/docs/optimizing-performance.html#examples)
  */
  
  class Board extends React.Component {
    // constructor(props) {
        // super(props);
        //  state 끌어 올리기 각 컴포넌트에서 관리 하는 state를 통하여 상태를 저장하는 것은 복잡하고 어렵다.
        //  부모 컴포너틑에 상태를 저장 하여 관리하는 것을 추천 한다.
        // this.state = {
        //     squares: Array(9).fill(null),
        //     xIsNext: true,
        // }
        //  여러개의 자식으로 부터 데이터를 모으거나 자식 컴포넌트들이 서로 통신하게 하려면 부모 컴포넌트에 공유 State를 정의 한다.
        //  부모 컴포넌트는 props를 사용 하여 자식 컴포넌트에 state를 다시 전달 할 수 있다.
        //  자식 컴포넌트들이 서로 또는 부모 컴포넌트와 동기화 하도록 한다.
    // }

    // handleClick(i) {
    //     const squares = this.state.squares.slice();
    //     if (calculateWinner(squares) || squares[i] ) {
    //         return;
    //     }
    //     squares[i] = this.state.xIsNext ? 'X' : 'O';
    //     this.setState({
    //         squares: squares,
    //         xIsNext: !this.state.xIsNext,
    //     });
    // }

    renderSquare(i) {
        //  props로 데이터 전달 하기.
        //  컴포넌트는 자신이 정의한 State에만 접근이 가능하기 때문에 다른 컴포넌트에서 State를 변경 할 수 는 없습니다.
        //  대신에 함수를 만들어 전달 합니다.
        //  React에서 이벤트를 나타내는 prop에는 on[Event], 이벤트를 처리하는 함수에는 handle[Event]를 사용 하는 것이 좋다.
      return <Square 
                // value={this.state.squares[i]}
                // onClick={() => this.handleClick(i)}
                value = {this.props.squares[i]}
                onClick={() => this.props.onClick(i)}
            />;
        //  @4. Board에서 Square로 onClick={() => this.handleClick(i)}를 전달 했기 때문에 Square를 클릭 하면 Board의 handleClick(i)를 호출 한다.
    }
  
    render() {
        // const winner = calculateWinner(this.state.squares);
        // let status;
        // if (winner) {
        //     status = 'Winner: ' + winner;
        // } else {
        //     status = 'Next player: ' + (this.state.xIsNext ? 'X' : 'O');
        // }
  
        return (
            <div>
            {/* <div className="status">{status}</div> */}
            <div className="board-row">
                {this.renderSquare(0)}
                {this.renderSquare(1)}
                {this.renderSquare(2)}
            </div>
            <div className="board-row">
                {this.renderSquare(3)}
                {this.renderSquare(4)}
                {this.renderSquare(5)}
            </div>
            <div className="board-row">
                {this.renderSquare(6)}
                {this.renderSquare(7)}
                {this.renderSquare(8)}
            </div>
            </div>
        );
    }
  }
  
  class Game extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            history: [{
                squares: Array(9).fill(null),
            }],
            stepNumber: 0,
            xIsNext: true,
        }
    }

    handleClick(i) {
        const history = this.state.history.slice(0, this.state.stepNumber + 1);
        const current = history[history.length - 1];
        const squares = current.squares.slice();
        if (calculateWinner(squares) || squares[i] ) {
            return;
        }
        squares[i] = this.state.xIsNext ? 'X' : 'O';
        this.setState({
            history: history.concat([{
                squares: squares,
            }]),
            stepNumber: history.length,
            xIsNext: !this.state.xIsNext,
        });
    }

    //  https://ko.reactjs.org/docs/state-and-lifecycle.html#state-updates-are-merged
    //  setState함수에 언급된 프로퍼티만 업데이트 한다.
    jumpTo(step) {
        this.setState({
            stepNumber: step,
            xIsNext: (step % 2) === 0,
        })
    }

    render() {
        const history = this.state.history;
        const current = history[this.state.stepNumber];
        const winner = calculateWinner(current.squares);

        //  step > 요소값 / move > 요소인덱스
        //  배열, 이터레이터의 자식들은 고유의 "key" prop를 가지고 있어야 한다.
        //  동적인 리스트를 만들 때마다 적절한 키를 할당할 것을 강력하게 추천합니다.
        //  키가 지정되지 않은 경우 React는 경고를 표시하며 배열의 인덱스를 기본 키로 사용한다.
        const moves = history.map((step, move) => {
            const desc = move ?
                'Go to move #' + move :
                'Go to game start';
            return (
                <li key={move}>
                    <button onClick={() => this.jumpTo(move)}>{desc}</button>
                </li>
            );
        });

        let status;
        if (winner) {
            status = 'Winner: ' + winner;
        } else {
            status = 'Next player:' + (this.state.xIsNext ? 'X' : 'O');
        }

        return (
            <div className="game">
            <div className="game-board">
                <Board 
                    squares = {current.squares}
                    onClick={(i)=>this.handleClick(i)}
                />
            </div>
            <div className="game-info">
                <div>{status}</div>
                <ol>{moves}</ol>
            </div>
            </div>
        );
    }
  }
  
  // ========================================
  
  const root = ReactDOM.createRoot(document.getElementById("root"));
  root.render(<Game />);
  
  function calculateWinner(squares) {
    const lines = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];
    for (let i = 0; i < lines.length; i++) {
      const [a, b, c] = lines[i];
      if (squares[a] && squares[a] === squares[b] && squares[a] === squares[c]) {
        return squares[a];
      }
    }
    return null;
  }