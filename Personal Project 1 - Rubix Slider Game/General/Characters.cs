using UnityEngine;
using System.Collections;

public class Characters : Variable_Holder {

    private Vector3 StationaryPosition;
    private Vector3 PStationaryPosition;

    private bool instantiated = false;
    private bool MovingTowards = false;
    public int value;
    Color32 Red = new Color32(255, 66, 66, 255);
    Color32 Blue = new Color32(51, 161, 255, 255);
    Color32 Yellow = new Color32(255, 255, 102, 255);


    void Start()
    {

        SpriteRenderer Sprite = GetComponent<SpriteRenderer>();

        if (transform.position.x == 1 && !Randomized)
        {
            Sprite.color = Red;
        }
        else if (transform.position.x == 3 && !Randomized)
        {
            Sprite.color = Yellow;
        }
        else if (transform.position.x == 5 && !Randomized)
        {
            Sprite.color = Blue;
        }

        StationaryPosition = new Vector2(transform.position.x, transform.position.y);

        if (GameObject.Find(this.gameObject.name) == null)
        {
            instantiated = false;
        }
        else
        {
            instantiated = true;
            PStationaryPosition = PStationary[value - 1];
        }

        if (!Randomized)
        {
            for (int i = 0; i < Direction.Count; i++)
            {
                if (Direction[i] == 11)
                {
                    if (StationaryPosition.x == 5)
                    {
                        if (StationaryPosition.y == 6)
                        {
                            StationaryPosition.y = 2;
                        }
                        else
                        {
                            StationaryPosition.y += 2;
                        }
                    }
                    else
                    {

                    }
                }
                else if (Direction[i] == 12)
                {
                    if (StationaryPosition.x == 5)
                    {
                        if (StationaryPosition.y == 2)
                        {
                            StationaryPosition.y = 6;
                        }
                        else
                        {
                            StationaryPosition.y -= 2;
                        }
                    }
                    else
                    {

                    }
                }
                else if (Direction[i] == 13)
                {
                    if (StationaryPosition.y == 4)
                    {
                        if (StationaryPosition.x == 5)
                        {
                            StationaryPosition.x = 1;
                        }
                        else
                        {
                            StationaryPosition.x += 2;
                        }
                    }
                    else
                    {

                    }
                }
                else if (Direction[i] == 14)
                {
                    if (StationaryPosition.y == 4)
                    {
                        if (StationaryPosition.x == 1)
                        {
                            StationaryPosition.x = 5;
                        }
                        else
                        {
                            StationaryPosition.x -= 2;
                        }
                    }
                    else
                    {

                    }
                }
                else if (Direction[i] == 21)
                {
                    if (StationaryPosition.x == 3)
                    {
                        if (StationaryPosition.y == 6)
                        {
                            StationaryPosition.y = 2;
                        }
                        else
                        {
                            StationaryPosition.y += 2;
                        }
                    }
                    else
                    {

                    }
                }
                else if (Direction[i] == 22)
                {
                    if (StationaryPosition.x == 3)
                    {
                        if (StationaryPosition.y == 2)
                        {
                            StationaryPosition.y = 6;
                        }
                        else
                        {
                            StationaryPosition.y -= 2;
                        }
                    }
                    else
                    {

                    }
                }
                else if (Direction[i] == 23)
                {
                    if (StationaryPosition.y == 6)
                    {
                        if (StationaryPosition.x == 5)
                        {
                            StationaryPosition.x = 1;
                        }
                        else
                        {
                            StationaryPosition.x += 2;
                        }
                    }
                    else
                    {

                    }
                }
                else if (Direction[i] == 24)
                {
                    if (StationaryPosition.y == 6)
                    {
                        if (StationaryPosition.x == 1)
                        {
                            StationaryPosition.x = 5;
                        }
                        else
                        {
                            StationaryPosition.x -= 2;
                        }
                    }
                    else
                    {

                    }
                }
                else if (Direction[i] == 31)
                {
                    if (StationaryPosition.x == 1)
                    {
                        if (StationaryPosition.y == 6)
                        {
                            StationaryPosition.y = 2;
                        }
                        else
                        {
                            StationaryPosition.y += 2;
                        }
                    }
                    else
                    {

                    }
                }
                else if (Direction[i] == 32)
                {
                    if (StationaryPosition.x == 1)
                    {
                        if (StationaryPosition.y == 2)
                        {
                            StationaryPosition.y = 6;
                        }
                        else
                        {
                            StationaryPosition.y -= 2;
                        }
                    }
                    else
                    {

                    }
                }
                else if (Direction[i] == 33)
                {
                    if (StationaryPosition.y == 4)
                    {
                        if (StationaryPosition.x == 5)
                        {
                            StationaryPosition.x = 1;
                        }
                        else
                        {
                            StationaryPosition.x += 2;
                        }
                    }
                    else
                    {

                    }
                }
                else if (Direction[i] == 34)
                {
                    if (StationaryPosition.y == 4)
                    {
                        if (StationaryPosition.x == 1)
                        {
                            StationaryPosition.x = 5;
                        }
                        else
                        {
                            StationaryPosition.x -= 2;
                        }
                    }
                    else
                    {

                    }
                }
                else if (Direction[i] == 41)
                {
                    if (StationaryPosition.x == 3)
                    {
                        if (StationaryPosition.y == 6)
                        {
                            StationaryPosition.y = 2;
                        }
                        else
                        {
                            StationaryPosition.y += 2;
                        }
                    }
                    else
                    {

                    }
                }
                else if (Direction[i] == 42)
                {
                    if (StationaryPosition.x == 3)
                    {
                        if (StationaryPosition.y == 2)
                        {
                            StationaryPosition.y = 6;
                        }
                        else
                        {
                            StationaryPosition.y -= 2;
                        }
                    }
                    else
                    {

                    }
                }
                else if (Direction[i] == 43)
                {
                    if (StationaryPosition.y == 2)
                    {
                        if (StationaryPosition.x == 5)
                        {
                            StationaryPosition.x = 1;
                        }
                        else
                        {
                            StationaryPosition.x += 2;
                        }
                    }
                    else
                    {

                    }
                }
                else if (Direction[i] == 44)
                {
                    if (StationaryPosition.y == 2)
                    {
                        if (StationaryPosition.x == 1)
                        {
                            StationaryPosition.x = 5;
                        }
                        else
                        {
                            StationaryPosition.x -= 2;
                        }
                    }
                    else
                    {

                    }
                }
            }

            transform.position = StationaryPosition;
        }

        if (PStationaryPosition != StationaryPosition)
        {
            if (transform.position == new Vector3(1, 6))
            {
                PStationaryPosition = StationaryPosition;
                ARow1 += value;
            }
            else if (transform.position == new Vector3(3, 6))
            {
                PStationaryPosition = StationaryPosition;
                ARow1 += value;
            }
            else if (transform.position == new Vector3(5, 6))
            {
                PStationaryPosition = StationaryPosition;
                ARow1 += value;
            }
            else if (transform.position == new Vector3(1, 4))
            {
                PStationaryPosition = StationaryPosition;
                ARow2 += value;
            }
            else if (transform.position == new Vector3(3, 4))
            {
                PStationaryPosition = StationaryPosition;
                ARow2 += value;
            }
            else if (transform.position == new Vector3(5, 4))
            {
                PStationaryPosition = StationaryPosition;
                ARow2 += value;
            }
            else if (transform.position == new Vector3(1, 2))
            {
                PStationaryPosition = StationaryPosition;
                ARow3 += value;
            }
            else if (transform.position == new Vector3(3, 2))
            {
                PStationaryPosition = StationaryPosition;
                ARow3 += value;
            }
            else if (transform.position == new Vector3(5, 2))
            {
                PStationaryPosition = StationaryPosition;
                ARow3 += value;
            }
        }
        StartCoroutine("Randomize");
    }
	
    IEnumerator Randomize()
    {
        yield return new WaitForEndOfFrame();
        Randomized = true;
    }

	// Update is called once per frame
	void FixedUpdate () {

        PStationary[value - 1] = PStationaryPosition;

        if (TouchInWorld2DB.x <= (transform.position.x + 1) && TouchInWorld2DB.x >= (transform.position.x - 1) && Vertical && CanSwipe)
        {
                Tetherer.position = new Vector2(TouchInWorld2DB.x, TouchInWorld.y);

            if (!instantiated && transform.position.y > 1 && transform.position.y < 3)
            {
                Instantiate(this.gameObject, new Vector3(transform.position.x, transform.position.y + 6), transform.rotation, Tetherer);
                Instantiate(this.gameObject, new Vector3(transform.position.x, transform.position.y - 6), transform.rotation, Tetherer);
                Instantiate(this.gameObject, new Vector3(transform.position.x, transform.position.y + 12), transform.rotation, Tetherer);
                Instantiate(this.gameObject, new Vector3(transform.position.x, transform.position.y - 12), transform.rotation, Tetherer);
                instantiated = true;
            }
            else if(!instantiated && transform.position.y > 3 && transform.position.y < 5)
            {
                Instantiate(this.gameObject, new Vector3(transform.position.x, transform.position.y + 6), transform.rotation, Tetherer);
                Instantiate(this.gameObject, new Vector3(transform.position.x, transform.position.y - 6), transform.rotation, Tetherer);
                Instantiate(this.gameObject, new Vector3(transform.position.x, transform.position.y + 12), transform.rotation, Tetherer);
                Instantiate(this.gameObject, new Vector3(transform.position.x, transform.position.y - 12), transform.rotation, Tetherer);
                instantiated = true;
            }
            else if(!instantiated && transform.position.y > 5 && transform.position.y < 7)
            {
                Instantiate(this.gameObject, new Vector3(transform.position.x, transform.position.y + 6), transform.rotation, Tetherer);
                Instantiate(this.gameObject, new Vector3(transform.position.x, transform.position.y - 6), transform.rotation, Tetherer);
                Instantiate(this.gameObject, new Vector3(transform.position.x, transform.position.y + 12), transform.rotation, Tetherer);
                Instantiate(this.gameObject, new Vector3(transform.position.x, transform.position.y - 12), transform.rotation, Tetherer);
                instantiated = true;
            }

            if (StationaryPosition.y > TouchInWorld.y)
            {
                transform.parent = Tetherer;
            }
            else if (StationaryPosition.y < TouchInWorld.y)
            {
                transform.parent = Tetherer;
            }
        }
        else if(TouchInWorld2DB.y <= (transform.position.y + 1) && TouchInWorld2DB.y >= (transform.position.y - 1) && Horizontal && CanSwipe)
        {
                Tetherer.position = new Vector2(TouchInWorld.x, TouchInWorld2DB.y);

            if (!instantiated && transform.position.x > 0 && transform.position.x < 2)
            {
                Instantiate(this.gameObject, new Vector3(transform.position.x + 6, transform.position.y), transform.rotation, Tetherer);
                Instantiate(this.gameObject, new Vector3(transform.position.x - 6, transform.position.y), transform.rotation, Tetherer);
                Instantiate(this.gameObject, new Vector3(transform.position.x + 12, transform.position.y), transform.rotation, Tetherer);
                instantiated = true;
            }
            else if (!instantiated && transform.position.x < 4 && transform.position.x > 2)
            {
                Instantiate(this.gameObject, new Vector3(transform.position.x + 6, transform.position.y), transform.rotation, Tetherer);
                Instantiate(this.gameObject, new Vector3(transform.position.x - 6, transform.position.y), transform.rotation, Tetherer);
                instantiated = true;
            }
            else if (!instantiated && transform.position.x > 4 && transform.position.x < 6)
            {
                Instantiate(this.gameObject, new Vector3(transform.position.x + 6, transform.position.y), transform.rotation, Tetherer);
                Instantiate(this.gameObject, new Vector3(transform.position.x - 6, transform.position.y), transform.rotation, Tetherer);
                Instantiate(this.gameObject, new Vector3(transform.position.x - 12, transform.position.y), transform.rotation, Tetherer);
                instantiated = true;
            }

            if (StationaryPosition.x > TouchInWorld.x)
            {
                transform.parent = Tetherer;
            }
            else if (StationaryPosition.x < TouchInWorld.x)
            {
                transform.parent = Tetherer;
            }
        }
        else
        {
            transform.parent = null;
            instantiated = false;
        }

        if((transform.position.x - 1) <= 1 && (transform.position.x - 1) > 0 && LetGo|| (1 - transform.position.x) <= 1 && (1 - transform.position.x) > 0 && LetGo)
        {
            transform.position = Vector2.MoveTowards(transform.position, new Vector2(1, transform.position.y), 0.1f);
            StationaryPosition = new Vector2(1, transform.position.y);
            MovingTowards = true;
        }
        else if ((transform.position.x - 3) <= 1 && (transform.position.x - 3) > 0 && LetGo || (3 - transform.position.x) <= 1 && (3 - transform.position.x) > 0 && LetGo)
        {
            transform.position = Vector2.MoveTowards(transform.position, new Vector2(3, transform.position.y), 0.1f);
            StationaryPosition = new Vector2(3, transform.position.y);
            MovingTowards = true;
        }
        else if((transform.position.x - 5) <= 1 && (transform.position.x - 5) > 0 && LetGo || (5 - transform.position.x) <= 1 && (5 - transform.position.x) > 0 && LetGo)
        {
            transform.position = Vector2.MoveTowards(transform.position, new Vector2(5, transform.position.y), 0.1f);
            StationaryPosition = new Vector2(5, transform.position.y);
            MovingTowards = true;
        }
        else if ((transform.position.y - 2) <= 1 && (transform.position.y - 2) > 0 && LetGo || (2 - transform.position.y) <= 1 && (2 - transform.position.y) > 0 && LetGo)
        {
            transform.position = Vector2.MoveTowards(transform.position, new Vector2(transform.position.x, 2), 0.1f);
            StationaryPosition = new Vector2(transform.position.x, 2);
            MovingTowards = true;
        }
        else if ((transform.position.y - 4) <= 1 && (transform.position.y - 4) > 0 && LetGo || (4 - transform.position.y) <= 1 && (4 - transform.position.y) > 0 && LetGo)
        {
            transform.position = Vector2.MoveTowards(transform.position, new Vector2(transform.position.x, 4), 0.1f);
            StationaryPosition = new Vector2(transform.position.x, 4);
            MovingTowards = true;
        }
        else if ((transform.position.y - 6) <= 1 && (transform.position.y - 6) > 0 && LetGo || (6 - transform.position.y) <= 1 && (6 - transform.position.y) > 0 && LetGo)
        {
            transform.position = Vector2.MoveTowards(transform.position, new Vector2(transform.position.x, 6), 0.1f);
            StationaryPosition = new Vector2(transform.position.x, 6);
            MovingTowards = true;
        }
        else if ((transform.position.y - 8) <= 1 && (transform.position.y - 8) > 0 && LetGo || (8 - transform.position.y) <= 1 && (8 - transform.position.y) > 0 && LetGo)
        {
            transform.position = Vector2.MoveTowards(transform.position, new Vector2(transform.position.x, 8), 0.1f);
            StationaryPosition = new Vector2(transform.position.x, 8);
            MovingTowards = true;
        }
        else if ((transform.position.y - 0) <= 1 && (transform.position.y - 0) > 0 && LetGo || (0 - transform.position.y) <= 1 && (0 - transform.position.y) > 0 && LetGo)
        {
            transform.position = Vector2.MoveTowards(transform.position, new Vector2(transform.position.x, 0), 0.1f);
            StationaryPosition = new Vector2(transform.position.x, 0);
            MovingTowards = true;
        }
        else if ((transform.position.x - 7) <= 1 && (transform.position.x - 7) > 0 && LetGo || (7 - transform.position.x) <= 1 && (7 - transform.position.x) > 0 && LetGo)
        {
            transform.position = Vector2.MoveTowards(transform.position, new Vector2(7, transform.position.y), 0.1f);
            StationaryPosition = new Vector2(7, transform.position.y);
            MovingTowards = true;
        }
        else if ((transform.position.x - -1) <= 1 && (transform.position.x - -1) > 0 && LetGo || (-1 - transform.position.x) <= 1 && (-1 - transform.position.x) > 0 && LetGo)
        {
            transform.position = Vector2.MoveTowards(transform.position, new Vector2(-1, transform.position.y), 0.1f);
            StationaryPosition = new Vector2(-1, transform.position.y);
            MovingTowards = true;
        }

        if (transform.position.x != StationaryPosition.x && MovingTowards || transform.position.y != StationaryPosition.y && MovingTowards)
        {
            CanSwipe = false;
        }
        else if (transform.position.x == StationaryPosition.x && MovingTowards || transform.position.y == StationaryPosition.y && MovingTowards)
        {
            CanSwipe = true;
            MovingTowards = false;
        }


        if(PStationaryPosition.y != StationaryPosition.y)
        {
            if (PStationaryPosition.y == 6 && StationaryPosition.y == 4)
            {
                PStationaryPosition = StationaryPosition;
                ARow1 -= value;
                ARow2 += value;
            }
            else if (PStationaryPosition.y == 6 && StationaryPosition.y == 2)
            {
                PStationaryPosition = StationaryPosition;
                ARow1 -= value;
                ARow3 += value;
            }
            else if (PStationaryPosition.y == 4 && StationaryPosition.y == 6)
            {
                PStationaryPosition = StationaryPosition;
                ARow2 -= value;
                ARow1 += value;
            }
            else if (PStationaryPosition.y == 4 && StationaryPosition.y == 2)
            {
                PStationaryPosition = StationaryPosition;
                ARow2 -= value;
                ARow3 += value;
            }
            else if (PStationaryPosition.y == 2 && StationaryPosition.y == 4)
            {
                PStationaryPosition = StationaryPosition;
                ARow3 -= value;
                ARow2 += value;
            }
            else if (PStationaryPosition.y == 2 && StationaryPosition.y == 6)
            {
                PStationaryPosition = StationaryPosition;
                ARow3 -= value;
                ARow1 += value;
            }
        }
        else if (PStationaryPosition.x != StationaryPosition.x)
        {
            PStationaryPosition = StationaryPosition;
        }

        if (transform.position.x >= 7 && LetGo|| transform.position.x <= -1 && LetGo|| transform.position.y >= 8 && LetGo || transform.position.y <= 0 && LetGo)
        {
            Destroy(this.gameObject);
        }
    }
}
