# BEFORE-prevent_self_follows
DELIMITER $$

create TRIGGER prevent_self_follows
    BEFORE INSERT ON follows for each ROW
    BEGIN
        IF NEW.follower_id=NEW.followee_id
        THEN
            SIGNAL SQLSTATE "45000"
                 SET MESSAGE_TEXT='Cannot follow yourself!';
        END IF;
    END;
$$ 


DELIMITER ; 





# AFTER logging unfollows


DELIMITER $$

create TRIGGER capture_unfollow
    AFTER DELETE ON follows for each ROW
    BEGIN
        # Option1
        # INSERT INTO unfollows(follower_id,followee_id)
        # VALUES(OLD.follower_id,OLD.followee_id)
        
#         Option 2
        INSERT INTO unfollows
        SET follower_id=OLD.follower_id,
            followee_id=OLD.followee_id;
        
    END ;
$$ 

DELIMITER ; 