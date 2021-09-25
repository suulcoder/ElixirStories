import RatingStars from "../RatingStars";
import './styles.css'

const AverageRating = ({ ratings }) => { 
    
    const get_average = my_array => {
       return (my_array.reduce((acc, current) => acc + current)/my_array.length);
    }   

    const average = Math.ceil(get_average(ratings.map(rate => rate.rate))) 

    return (
        <div className="average_title">
            <h2 className="average_title_text"> {'AVERAGE RATING: ' + average} </h2>
            <RatingStars rate={average} on_title={true}/>
        </div> 
    );
};

export default AverageRating