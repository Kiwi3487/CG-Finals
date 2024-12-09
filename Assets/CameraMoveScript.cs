using UnityEngine;

public class CameraMoveScript : MonoBehaviour
{
    public float moveSpeed = 5f;     // Movement speed
    public float lookSpeed = 2f;     // Mouse look sensitivity
    public float verticalSpeed = 3f; // Speed for moving up/down (Q/E)
    
    private float xRotation = 0f;
    private float yRotation = 0f;

    void Update()
    {
        // Handle camera movement (WASD or Arrow keys)
        float horizontal = Input.GetAxis("Horizontal") * moveSpeed * Time.deltaTime;
        float vertical = Input.GetAxis("Vertical") * moveSpeed * Time.deltaTime;
        float upDown = 0f;

        // Move camera up and down with Q and E
        if (Input.GetKey(KeyCode.Q))
        {
            upDown = -verticalSpeed * Time.deltaTime;  // Move down
        }
        if (Input.GetKey(KeyCode.Space))
        {
            upDown = verticalSpeed * Time.deltaTime;  // Move up
        }

        // Apply movement to the camera (forward/backward and left/right)
        transform.Translate(horizontal, upDown, vertical);

        // Handle camera rotation (mouse movement)
        float mouseX = Input.GetAxis("Mouse X") * lookSpeed;
        float mouseY = Input.GetAxis("Mouse Y") * lookSpeed;

        // Rotate the camera horizontally (left-right)
        yRotation += mouseX;
        yRotation = Mathf.Repeat(yRotation, 360f); // Prevent it from getting too large
        transform.localRotation = Quaternion.Euler(0f, yRotation, 0f);  // Apply Y-axis rotation

        // Rotate the camera vertically (up-down) with clamping
        xRotation -= mouseY;
        xRotation = Mathf.Clamp(xRotation, -80f, 80f);  // Limit vertical look angle
        Camera.main.transform.localRotation = Quaternion.Euler(xRotation, yRotation, 0f);  // Apply X-axis rotation
    }
}