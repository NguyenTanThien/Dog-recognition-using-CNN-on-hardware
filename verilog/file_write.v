module write_file #(
					parameter FILENAME="lena_sink.txt",
					parameter DATA_WIDTH = 32,
					parameter SIZE = 1024
				  )
  (
	input     wire                      clk,
	input     wire                      rst,
	input     wire                      enable,
	input     wire    [DATA_WIDTH-1:0]  data               // Data per one pixel of image
	//input     wire                      data_valid_out,       // That signal confirm that data input are valid
              // Stop transfer signal
  );
  
	integer data_file;             // Return value of file that open to write
	reg     write_info=1'b0;
	reg [15:0] frames;
	//reg []
	// Initial create file to write
	initial begin
      data_file = $fopen(FILENAME, "w");   //Create file for writing value
	 // Check progress is completed without errors
	 if (data_file == 0)
		begin
			$display("File isnt created!");	
		  $finish;     // Break if file cant be created
   	end 
   end
   reg ter;
   reg [31:0]count;
   always @(posedge clk or negedge rst)begin
     if(rst ==0)count = 0;
     else if(enable == 1)begin
       count <=count +1;
       
     end
   else count <= count;
     
   end
   always @(posedge clk or negedge rst)begin
     if(rst == 0) ter = 0;
     else if(count == SIZE) ter = 1;
     else ter = ter;
     
   end
  
   
   // Always procedural
   // Writing value
  always @(posedge clk) begin
    // If data input is valid and data input isnt enough, write value
		if (ter) begin
			  $fclose	(data_file);
			  //$finish;   // Finish process
				// End write and close file if data is enough
		end
    else if (enable == 1'b1) begin
			$fwrite(data_file,"%b\n",data);         // Write 8bit GREY_IMAGE for 1 pixel
			//$display("Data_out = %b",data);
		end
	
	end
endmodule
