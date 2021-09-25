import RatingStars from "../RatingStars";
import './styles.css'

const Ratings = ({ rating }) => { 
    return (
        <div className="rating">
            <div className={"rating_title"}>
                <h3> {rating.name} </h3>
                <RatingStars rate={Math.ceil(rating.rate)}/>
            </div>
            <p> {rating.properties} </p>
        </div> 
    );
};

export default Ratings