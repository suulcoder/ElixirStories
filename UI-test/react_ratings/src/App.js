import logo from './logo.svg';
import './App.css';
import RatingsList from './components/RatingsList';

const ratings = [
  {
    name: 'Test1',
    properties: 'Properties1',
    rate: 4.01
  },
  {
    name: 'Test2',
    properties: 'Properties2',
    rate: 3.01
  },
  {
    name: 'Test3',
    properties: 'Properties3',
    rate: 4.0
  },
  {
    name: 'Test4',
    properties: 'Properties4',
    rate: 1.01
  },
  {
    name: 'Test5',
    properties: 'Properties5',
    rate: 2.45
  },
]

function App() {
  return (
    <div className="App-header">
      <RatingsList ratings={ratings}/>
    </div>
  );
}

export default App;
