using UnityEngine;
using System.Collections;

public class Scrolling : Variable_Holder {

    TouchPhase TouchBegin = TouchPhase.Began;
    TouchPhase TouchMove = TouchPhase.Moved;
    public TouchPhase TouchEnd = TouchPhase.Ended;

    bool Checked = false;


    // Update is called once per frame
    void Update () { 
        if(Input.touchCount > 0 && Input.GetTouch(0).phase == TouchBegin)
        {
            TouchInWorld = Camera.main.ScreenToWorldPoint(Input.GetTouch(0).position);

            TouchInWorld2DB = new Vector2(TouchInWorld.x, TouchInWorld.y);

            LetGo = false;

        }
        else if(Input.touchCount > 0 && Input.GetTouch(0).phase == TouchMove)
        {
                TouchInWorld = Camera.main.ScreenToWorldPoint(Input.GetTouch(0).position);

            if ((TouchInWorld2DB.x - TouchInWorld.x) >= 0.3f && !Checked || (TouchInWorld.x - TouchInWorld2DB.x) >= 0.3f && !Checked)
            {
                Horizontal = true;
                Checked = true;
            }
            else if ((TouchInWorld2DB.y - TouchInWorld.y) >= 0.2f && !Checked || (TouchInWorld.y - TouchInWorld2DB.y) >= 0.2f && !Checked)
            {
                Vertical = true;
                Checked = true;
            }

        }
        else if (Input.touchCount > 0 && Input.GetTouch(0).phase == TouchEnd)
        {
            Checked = false;
            Vertical = false;
            Horizontal = false;
            LetGo = true;
            TouchInWorld2DB = new Vector2(-1, -1);
        }

	}
}
