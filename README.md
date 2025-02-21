# Digital-Clock-System

A digital clock system implemented with VHDL via Intel Quartus Prime and ModelSim.

## Test Scenarios
1.	_Testing the reset functionality_: When the reset signal is asserted, the clock's time components (seconds, minutes, and hours) are set to zero, ensuring a fresh start and providing a reliable baseline for timekeeping.

![image](https://github.com/user-attachments/assets/81df996c-690a-44aa-aa30-7aeba981a865)

2.	_Testing the seconds incrementation_: The testing of the seconds incrementation in the digital clock was successful, as observed in the waveform where the seconds component incremented correctly at each rising edge of the clock signal, validating its accurate timekeeping functionality.

![image](https://github.com/user-attachments/assets/5145ebc3-04bd-4cce-b812-c0bbbfcce457)

3.	_Testing the minutes incrementation_: It was observed that the minutes incremented correctly at each rising edge of the clock signal, after the second counter completed 59 counts, confirming the reliable functionality of the clock.

![image](https://github.com/user-attachments/assets/61bce5ad-86ba-4e0e-ba2f-dacf306fa28c)

4.	_Testing the hours Incrementation_: The observed waveform demonstrated that the hours were consistently incremented with precision reliably after the count of 59 minutes.

![image](https://github.com/user-attachments/assets/a8618030-d8cf-46e3-9a0e-90e98a6709b2)

5.	_Testing the reset after the 24 hour count_: By simulating the clock operation for a full 24-hour period and asserting the reset signal, the waveform was analyzed to ensure the clock properly reset to 1 and the rest of inputs and outputs to 0, allowing for seamless continuation of timekeeping beyond 24 hours.

![image](https://github.com/user-attachments/assets/58a822ff-be94-4fc4-acb7-4057da92087c)
