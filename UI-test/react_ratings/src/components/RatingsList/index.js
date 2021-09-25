import AverageRating from "../AverageRating";
import Rating from "../Rating";
import './styles.css'

const RatingsList = ({ ratings }) => { 
    return (
        <div>
            <AverageRating ratings={ratings}/>
            <div className={"ratings"}>
                {/* <Rating /> all the ratings individually */
                    ratings.map(
                        rating => <Rating rating={rating}/>
                    )
                }
            </div>
        </div> 
    );
};

export default RatingsList