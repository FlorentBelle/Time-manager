
<template>
  <div class="container rounded bg-white mt-5 mb-5">
    <div class="row">
        <div class="col-md-3 border-right center">
            <div class="d-flex flex-column align-items-center text-center p-3 py-5"><span class="font-weight-bold ">Edogaru</span><span> </span></div>
            <div class="d-flex flex-column align-items-center text-center p-3 py-5"><span class="text-black-50">edogaru@mail.com.my</span><span> </span></div>
        </div>
        <div class="line"></div>
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
            
                <div class="mt-5 text-center "><button class="btn btn-primary profile-button" type="submit"><span>Save</span><img src="https://i.cloudup.com/2ZAX3hVsBE-3000x3000.png" height="30" width="30"></button></div>
            </div>
        </div>
        
    </div>
  </div>
</template>

<style scoped>
.line{
  border-top: 1px solid black;
}
.profile-button{
  margin-top: 20px;
  margin-left: -50px
}
* {
  color: black;
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
  width: 30%;
  padding: 12px 20px;
  margin: 8px 0;
  box-sizing: border-box;
  border: 3px solid #ccc;
  -webkit-transition: 0.5s;
  transition: 0.5s;
  outline: none;
}
.form-control:focus {

  border: 3px solid #6fb07f;
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

@-webkit-keyframes extend {
    0% {
        width: 100px;
        height: 50px;
        border-radius: 100px;
        } 10% {
        width: 110px;
        height: 60px;
        background: #fff;
        margin-left: - 5px;
        margin-top: - 5px;
        } 20% {
        width: 100px;
        height: 50px;
        background: #6fb07f;
        margin-left: 0px;
        margin-top: 0px;
        } 100% {
        width: 50px;
        height: 50px;
        border-radius: 100px;
        margin-left: 190px;
        background: #6fb07f;
        }
    }
@keyframes extend {
    0% {
        width: 100px;
        height: 50px;
        border-radius: 100px;
        } 10% {
        width: 110px;
        height: 60px;
        background: #fff;
        margin-left: - 5px;
        margin-top: - 5px;
        } 20% {
        width: 100px;
        height: 50px;
        background: #6fb07f;
        margin-left: 0px;
        margin-top: 0px;
        } 100% {
        width: 50px;
        height: 50px;
        border-radius: 100px;
        margin-left: 190px;
        background: #6fb07f;
        }
    }

@-webkit-keyframes disappear {
    0% {
        opacity: 1;
        } 20% {
        color: #fff;
        } 100% {
        opacity: 0;
        }
    }
@keyframes disappear {
    0% {
        opacity: 1;
        } 20% {
        color: #fff;
        } 100% {
        opacity: 0;
        }
    }

@-webkit-keyframes appear {
    0% {
        opacity: 0;
        } 70% {
        opacity: 0;
        } 100% {
        opacity: 1;
        }
    }
@keyframes appear {
    0% {
        opacity: 0;
        } 70% {
        opacity: 0;
        } 100% {
        opacity: 1;
        }
    }


.cont {
    position: absolute;
    width: 110px;
    height: 10px;
    left: 50%;
    top: 50%;
    margin: -100px 0 0 -300px;
    display: block
    }

button {
    border-width: 1px;
    width: 100px;
    height: 50px;
    /*border-radius*/
    border-radius: 100px;
    background: #fff;
    position: absolute;
    border: 5px solid #6fb07f
    }

button > span {
    font-size: 25px;
    color: #6fb07f
    }

img {
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    margin: auto;
    -ms-filter: "progid:DXImageTransform.Microsoft.Alpha(Opacity=0)";
    filter: alpha(opacity=0);
    opacity: 0
    }

button:focus {
    /*animation*/
    -webkit-animation: extend 1s ease-in-out;
    -ms-animation: extend 1s ease-in-out;
    animation: extend 1s ease-in-out;
    -webkit-animation-fill-mode: forwards;
    /* Chrome, Safari, Opera */
    animation-fill-mode: forwards
    }

button:focus > span {
    /*animation*/
    -webkit-animation: disappear 1s ease-in-out;
    -ms-animation: disappear 1s ease-in-out;
    animation: disappear 1s ease-in-out;
    -webkit-animation-fill-mode: forwards;
    /* Chrome, Safari, Opera */
    animation-fill-mode: forwards
    }

button:focus > img {
    /*animation*/
    -webkit-animation: appear 1s ease-in-out;
    -ms-animation: appear 1s ease-in-out;
    animation: appear 1s ease-in-out;
    -webkit-animation-fill-mode: forwards;
    /* Chrome, Safari, Opera */
    animation-fill-mode: forwards
    }
</style>
