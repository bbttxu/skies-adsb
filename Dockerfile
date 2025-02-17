FROM fedora:38

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy the current directory contents into the container at /usr/src/app
COPY . .

# Install any needed packages specified in requirements.txt 
RUN dnf clean all
RUN dnf update -y
RUN dnf install python-websockify procps-ng nodejs python3 python3-pip -y
RUN pip install --no-cache-dir -r requirements.txt
RUN npm install

# Make port 80 available to the world outside this container (Optional, only for web apps)
EXPOSE 5173

# Define environment variable (optional)
ENV VITE_USE_EXISTING_ADSB World

# Run app.py when the container launches
CMD ["./use_existing_adsb.sh"]

