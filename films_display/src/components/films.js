import React from 'react';

function Films(props) {
  return <div>
      <h1>These films are from the Ruby API</h1>
      {props.films.map((film) => {
        return <div key={film.id}>
          <h2>{film.title}</h2>
        </div>
      })}
    </div>
}

export default Films;
