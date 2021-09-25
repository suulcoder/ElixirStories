import filledstar from '../../static/img/filledstar.png'
import emptystar from '../../static/img/emptystar.png'
import './styles.css'

const RatingStars = ({ rate, on_title }) => { 
    return (
        <div>
            {
                Array(5).fill(null).map(
                    (element,index) => {
                        return ((index<=rate) ?
                            <span>
                                <img className={on_title?"star_title":"star"} src={filledstar} alt={"filledstar"}/>
                            </span>
                        :
                            <span>
                                <img className={on_title?"star_title":"star"} src={emptystar} alt={"emptystar"}/>
                            </span>)
                    } 
                )
            }
        </div> 
    );
};

export default RatingStars