
<template>
  <div class="container rounded bg-white mt-5 mb-5">
    <div class="row">
        <div class="col-md-3 border-right center">
            <div class="d-flex flex-column align-items-center text-center p-3 py-5"><span class="font-weight-bold ">Edogaru</span><span> </span></div>
            <div class="d-flex flex-column align-items-center text-center p-3 py-5"><span class="text-black-50">edogaru@mail.com.my</span><span> </span></div>
        </div>
        <div class="col-md-5 border-right">
            <div class="p-3 py-5 edit">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h4 class="text-right">Edit Profile</h4>
                </div>
                <div class="row mt-2">
                    <div class="col-md-6"><label class="labels">Name: </label><input type="text" class="form-control" placeholder="Enter name" value=""></div>
                </div>
                <div class="row mt-3">
                    <div class="col-md-12"><label class="labels">Email: </label><input type="text" class="form-control" placeholder="Enter email" value=""></div>
                </div>
            
                <div class="mt-5 text-center"><button class="btn btn-primary profile-button" type="submit">Save Profile</button></div>
            </div>
        </div>
        
    </div>
  </div>
</template>

<style scoped>
* {
  color: white;
}
.edit{
  margin: auto;
  width: 50%;
  padding: 10px;
  text-align: center;
}
body {
  background: rgb(246, 163, 163)
}

.form-control{
  font-size: 15px;
}
.form-control:focus {
    box-shadow: none;
    border-color: #f3a1a1
}

.profile-button {
  background: rgb(246, 163, 163);
  box-shadow: none;
  padding: 10px;
  border: 1px solid gray;
  border-radius: 5px;
  font: inherit;
    
}

.profile-button:hover {
    background: #f3a1a1;
    box-shadow: 0 12px 16px 0 rgba(0,0,0,0.24), 0 17px 50px 0 rgba(0,0,0,0.19);
}

.profile-button:focus {
    background: #f3a1a1;
    box-shadow: none
}

.profile-button:active {
    background: #f3a1a1;
    box-shadow: none
}

.back:hover {
    color: #f3a1a1;
    cursor: pointer
}

.labels {
    font-size: 25px;
    display: block;

}

.add-experience:hover {
    background: #BA68C8;
    color: #fff;
    cursor: pointer;
    border: solid 1px #BA68C8
}
.center{
  margin: auto;
  width: 50%;
  padding: 10px;
  text-align: center;
  font-size: 25px;
  font-family: Georgia, serif	;

}
</style>
