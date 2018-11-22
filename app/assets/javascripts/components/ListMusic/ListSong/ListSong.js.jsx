class ListSong extends React.Component {
  render() {
    const {song} = this.props
    let song_path = "songs/".concat(song.id.toString())
    let list_author = song.authors.map(author => {
      return <a href="">{author.name}</a>
    })

    return(
      <div className="single-news mb-lg-0 mb-4">
        <div className="row">
          <div className="col-md-3">
            <div className="view overlay rounded z-depth-1 mb-lg-0 mb-4">
              <img src={song.image.image_url.url} className="img-fluid height-10 width-10" />
              <a><div className="mask rgba-white-slight waves-effect waves-light"></div></a>
            </div>
          </div>
          <div className="col-md-9">
            <a href={song_path} className="font-weight-bold dark-grey-text">{song.name}</a>
            <div className="d-flex justify-content-between">
              <div className="col-11 text-truncate pl-0 mb-lg-0 mb-3">
                {list_author}
              </div>
              <a href={song_path}>
                <i className="fa fa-play-circle-o fa-fw"></i>
              </a>
            </div>
            <i className="dark-grey-text">{song.category.name}</i>
          </div>
        </div>
      </div>
    )
  }
}
