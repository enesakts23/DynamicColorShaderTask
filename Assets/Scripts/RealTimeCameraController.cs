using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace SugARTechnology.Scripts 
{
    public class RealTimeCameraController : MonoBehaviour
    {
        #region CameraSettings
        public float moveSpeed = 10f; 
        public float zoomSpeed = 5f;    
        public float minY = 1f;         
        public float maxY = 15f;        
        #endregion

        void Update()
        {
            float horizontal = Input.GetAxis("Horizontal");
            float vertical = Input.GetAxis("Vertical");
            transform.Translate(new Vector3(horizontal, 0f, vertical) * moveSpeed * Time.deltaTime);


            float scroll = Input.GetAxis("Mouse ScrollWheel");
            Vector3 newPosition = transform.position + transform.forward * scroll * zoomSpeed;
            newPosition.y = Mathf.Clamp(newPosition.y, minY, maxY);  
            transform.position = newPosition;
        }
    }

}
